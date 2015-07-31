# wdi-project-2 (aka: Job-Match App)

Check it out at [http://job-match.herokuapp.com/](http://job-match.herokuapp.com/)

###Object
The object of the web application is to enhance job searching through visual display and auto-generated analysis. The site generates a "match score" by comparing a user's resume to the language used in job postings of the user's choice. 

###Technologies Used
I used Ruby on Rails, jQuery, Ajax, the jqCloud library, the Indeed API, Twitter Bootstrap, Indeed gem, Nokogiri gem, Bcrypt gem, among others. 

###Approach
I built job-match with two models, Users and Jobs, which both utilize the Indeed API. I also built methods to scrape additional data that was not included with the API - namely the full job description. The data is then manipulated to be received by jqCloud in JavaScript, and to provide an array of words to compare to the user's resume. Once the user enters their resume, an array of the words is processed and compared with the job description array, and together they are used to calculate a "match score." The match score is currently calculated by dividing the number of shared, key words between a user's resume and the job description, dividing that number by the number of words in the job posting, and multiplying by 100. This needs revision, which I address below.

###Installation Instructions
Download the files. Run bundle, db:migrate, and Foreman Rails S to run the app on a local server.

###Unsolved Problems
The first area for future development should be the algorithm which generates the match scores. I developed a very simplistic equation to get the app working, but need to incorporate additional factors into my calculations, such as the length of a user's resume, and give weighting to certain types of shared words (such as words that appear in the title). 

The seocond area that needs to be addressed is the routing for jobs. Initially when I planned the website, I anticipated displaying the resume and jobs on the same page, which I called the "Profile page." I decided to separate the two towards the end of the development process, which left my routes rather confusing. 

Additional areas needing future work include:

* Regarding job searching on the main page: 
	* search results need to be displayed with ajax - some actions are currently very slow
	* show additional results up to 25 on scroll
	* visually identify jobs within search results that already appear on a user's board
* Usability issues with modals when user causes a form error

###Wireframe Links
1) [https://generalassembly.mybalsamiq.com/mockups/3371804.png?key=d50bf25d97f905fddd89aa96ed5d4022296bcd00](https://generalassembly.mybalsamiq.com/mockups/3371804.png?key=d50bf25d97f905fddd89aa96ed5d4022296bcd00)

2) [https://generalassembly.mybalsamiq.com/mockups/3371828.png?key=d73d83960f34df8c870f64cc593f1468a42a1c3b](https://generalassembly.mybalsamiq.com/mockups/3371828.png?key=d73d83960f34df8c870f64cc593f1468a42a1c3b)

3) [https://generalassembly.mybalsamiq.com/mockups/3371864.png?key=b11bb371b838f076937da25204a16aae7e524d32](https://generalassembly.mybalsamiq.com/mockups/3371864.png?key=b11bb371b838f076937da25204a16aae7e524d32)

###User stories - main ideas:

1) As a job-seeker I want to find a job that fits my skills, experience, and goals, so that I can be employed in an appropriate position.

1 v2) As a job-seeker I want to find a job that fits my skills, experience, and goals, so that I can explore/identify how my skills, experience, and goals could translate into satisfying work

2) As a student I want to explore the job market, so that I can find out what type of job might suit me after graduation.


