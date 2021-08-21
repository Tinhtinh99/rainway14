import java.time.LocalDate;

public class Question {
	short 				questionId;
	String 				content;
	CategoryQuestion	categoryQuestion;
	TypeQuestion		typeQuestion;
	Account				creator;
	LocalDate			createDate;
	Exam[]				exam;
}