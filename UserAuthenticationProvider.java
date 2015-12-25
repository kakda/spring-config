package com.mcnc.yuga.security.provider;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.mcnc.yuga.dto.Employee;
import com.mcnc.yuga.dto.Project;
import com.mcnc.yuga.helper.security.AppUser;
import com.mcnc.yuga.helper.security.McncAuthenticationToken;
import com.mcnc.yuga.helper.security.Role;
import com.mcnc.yuga.service.EmployeeService;
import com.mcnc.yuga.service.ProjectService;

public class UserAuthenticationProvider implements AuthenticationProvider {

	final Logger logger = LoggerFactory.getLogger(UserAuthenticationProvider.class);
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private ProjectService projectService;
	
	public Authentication authenticate(Authentication authentication) throws NullPointerException{

		String employeeName = this.retrieveUserName(authentication);
		String password = this.retrievePassword(authentication);
		Employee employee = employeeService.getEmployeeByName(employeeName);
		logger.info("Loading user record for employee anme : {}", employeeName);
		
		if (employee == null) {
			throw new UsernameNotFoundException("User " + employeeName + " not found");
		}else if(employee.getIsReset().equalsIgnoreCase("Y")){
			return this.authenticatedEmployee(employee, this.getGrantedAuthority(employee.getRole()));
		}

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(! encoder.matches(password, employee.getPassword())) {
			throw new UsernameNotFoundException("Invalid password");
		}
		String role = Role.ROLE_EMPLOYEE.getValue();
		Project project = projectService.getProjectByEmployeeID(employee.getEmployeeID());
		if(!employee.getRole().equals(Role.ROLE_SUPER_USER.getValue()) && null != project){		
			role = Role.ROLE_PM.getValue();
		}else{
			role = employee.getRole();
		}
		
		return this.authenticatedEmployee(employee, this.getGrantedAuthority(role));
	}
	
	private Authentication authenticatedEmployee(Employee employee, Collection<? extends GrantedAuthority> authority) {
		boolean isReset =  employee.getIsReset().equalsIgnoreCase("Y");
		if(isReset) {
			employee.setPassword(null);
		}
		AppUser appUser = new AppUser(employee.getEmployeeName(), isReset, Role.getEnum(employee.getRole()), employee.getEnrolledDate());
		return new McncAuthenticationToken(employee.getEmployeeID(), employee.getPassword(), authority, appUser);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}
	
	private Collection<? extends GrantedAuthority> getGrantedAuthority(String role) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority(role));
		return authorities;
	}
	
	private String retrieveUserName(Authentication authentication) {
        if (isInstanceOfUserDetails(authentication)) {
            return ((UserDetails) authentication.getPrincipal()).getUsername();
        }
        else {
            return authentication.getPrincipal().toString();
        }
    }

    private String retrievePassword(Authentication authentication) {
        if (isInstanceOfUserDetails(authentication)) {
            return ((UserDetails) authentication.getPrincipal()).getPassword();
        }
        else {
            if (authentication.getCredentials() == null) {
                return null;
            }
            return authentication.getCredentials().toString();
        }
    }

    private boolean isInstanceOfUserDetails(Authentication authentication) {
        return authentication.getPrincipal() instanceof UserDetails;
    }	
}
