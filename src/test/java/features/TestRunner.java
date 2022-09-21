package features;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

	@Karate.Test
	Karate getUserTest() {
		return Karate.run("jsonHolderPostUser").tags("setJsonRequest").relativeTo(getClass());
	}
}
