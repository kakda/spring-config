package com.mcnc.yuga.helper.key;

import java.util.ArrayList;
import java.util.List;

public final class Sort {

	public static enum Level{
		Level1,
		Level2,
		Level3
	}
	
	public static enum Level1{
		Accrual,
		Proportional,
		Plan,
		Gap
	}
	
	public static enum Level2{
		
		Cost	("Cost"),
		Revenue	("Revenue"),
		TeamProfitLoss("Team Profit/Loss"),
		AccumulatedPL("Accumulated P/L"),
		NetProfitByMonth("Net Profit by Month"),
		AccumulatedProfit("Accumulated Profit"),
		MonthlyGap("Monthly Gap"),
		AccumulatedGap("Accumulated Gap");
		
		private final String value;
		
		private Level2(String value) {
			this.value = value;
		}
		
		public String getValue() {
			return value;
		}

		@Override
		public String toString() {
			return value;
		}
		
	}
	
	public static enum Level3{
		Accrual,
		Proportional
	}
	
	public enum TeamGP{
		
		PL							(""),
		REVENUE_SERVICE				("(+) Service Revenue from Own Projects"),
		REVENUE_INTERNAL_BILLING	("(+) Internal Billing Revenue"),
		COST_OUTSOURCING			("(-) Outsourcing Cost"),
		COST_INTERNAL_OUTSOURCING	("(-) Internal Outsourcing Cost"),
		COST_PROJECT_EXPENSE		("(-) Project Expense");

		private final String value;
		
		private TeamGP(String value) {
			this.value = value;
		}
		
		public String getValue() {
			return value;
		}

		@Override
		public String toString() {
			return value;
		}
		
		public static List<String> getLists(){
			
			List<String> str = new ArrayList<String>();
			for(TeamGP value : TeamGP.values()){   
			    str.add(value.getValue());
			}
			return str;
		}
	}
	
	
	public static class TeamProfit{
		
		public static enum Revenue{	
			
			REVENUE						(""),
			REVENUE_SI_SM				("Team-owned SI/SM Project Revenue"),
			REVENUE_INTERNAL_RD			("Team-owned Internal R&D Project Revenue"),
			REVENUE_INTERNAL_BILLING	("Internal Billing Revenue"),
			REVENUE_NON_BILLABLE		("Non-Billable SM Revenue"),
			REVENUE_MA_REVENUE			("MA Revenue");		

			private final String value;
			
			private Revenue(String value) {
				this.value = value;
			}
			
			public String getValue() {
				return value;
			}

			@Override
			public String toString() {
				return value;
			}
			
			public static List<String> getLists(){
				
				List<String> str = new ArrayList<String>();
				for(Revenue value : Revenue.values()){   
				    str.add(value.getValue());
				}
				return str;
			}
		}// end revenue

		public static enum Cost{	
			
			COST						(""),
			COST_TEAM_INTERNAL			("Team Internal Cost"),
			COST_INTERNAL_OUTSOURCING	("Internal Outsourcing"),
			COST_OUTSOURCING			("Outsourcing"),
			COST_PARTY_SOLUTION			("3rd Party Solution"),
			COST_PROJECT_EXPENSE		("Project Expense"),
			COST_SALES_OPEX				("Sales OPEX");	

			private final String value;
			
			private Cost(String value) {
				this.value = value;
			}
			
			public String getValue() {
				return value;
			}

			@Override
			public String toString() {
				return value;
			}
			
			public static List<String> getLists(){
				
				List<String> str = new ArrayList<String>();
				for(Cost value : Cost.values()){   
				    str.add(value.getValue());
				}
				return str;
			}
		}// end cost
	
		public static enum Accumulated {	
			
			TEAM_PROFIT_LOST		("Team Profit/Loss"),
			ACCUMALATED_PL			("Accumulated P/L");
			

			private final String value;
			
			private Accumulated(String value) {
				this.value = value;
			}
			
			public String getValue() {
				return value;
			}

			@Override
			public String toString() {
				return value;
			}
			
			public static List<String> getLists(){
				
				List<String> str = new ArrayList<String>();
				for(Accumulated value : Accumulated.values()){   
				    str.add(value.getValue());
				}
				return str;
			}
		}// end Accumulated
		
		
		public static enum Plan {	
			
			NET_PROFIT_BY_MONTH		("Net Profit by Month"),
			ACCUMULATED_PROFIT		("Accumulated Profit");
			

			private final String value;
			
			private Plan(String value) {
				this.value = value;
			}
			
			public String getValue() {
				return value;
			}

			@Override
			public String toString() {
				return value;
			}
			
			public static List<String> getLists(){
				
				List<String> str = new ArrayList<String>();
				for(Plan value : Plan.values()){   
				    str.add(value.getValue());
				}
				return str;
			}
		}// end Plan
		
		public static enum Gap {	
			
			MONTHLY_GAP		("Monthly Gap"),
			ACCUMULATED_GAP		("Accumulated Gap");
			

			private final String value;
			
			private Gap(String value) {
				this.value = value;
			}
			
			public String getValue() {
				return value;
			}

			@Override
			public String toString() {
				return value;
			}
			
			public static List<String> getLists(){
				
				List<String> str = new ArrayList<String>();
				for(Gap value : Gap.values()){   
				    str.add(value.getValue());
				}
				return str;
			}
		}// end Gap
	
	}
	
	
}
