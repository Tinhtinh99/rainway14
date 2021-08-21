import java.time.LocalDate;

public class Exam {
	byte				examId;
	String				code;
	String				title;
	CategoryQuestion 	categoryQuestion;
	byte 	 			duration;
	Account				creator;
	LocalDate			createDate;
	Question[]			question;
}
