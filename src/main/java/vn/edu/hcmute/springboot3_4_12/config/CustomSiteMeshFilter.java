package vn.edu.hcmute.springboot3_4_12.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;


public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter{


	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		// Decorator mặc định cho user
		builder.addDecoratorPath("/*", "/user-decorator.jsp");

		// Decorator cho admin
		builder.addDecoratorPath("/admin/*", "/admin-decorator.jsp");
	}
}
