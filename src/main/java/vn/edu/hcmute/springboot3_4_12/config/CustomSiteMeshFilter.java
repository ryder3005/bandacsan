package vn.edu.hcmute.springboot3_4_12.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;


public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		// Loại trừ các trang không cần decorator
		builder.addExcludedPath("/login");
		builder.addExcludedPath("/register");
		builder.addExcludedPath("/error");
		builder.addExcludedPath("/api/*");
		builder.addExcludedPath("/resources/*");
		builder.addExcludedPath("/perform_login");
		
		// Decorator cho admin (use decorator filenames — SiteMesh uses WEB-INF/decorators as base)
		builder.addDecoratorPath("/admin/*", "/admin-decorator.jsp");

		// Decorator cho vendor
		builder.addDecoratorPath("/vendor/*", "/vendor-decorator.jsp");

		// Decorator cho user
		builder.addDecoratorPath("/user/*", "/user-decorator.jsp");
	}
}
