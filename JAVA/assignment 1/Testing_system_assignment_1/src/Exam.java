import java.util.Arrays;

public class Exam {
	int id;
	String code;
	String title;
	CategoryQuestion categoryQuestion;
	String duration;
	Account creatorExam;
	String createDate;
	Question questionSinger;
	Question[] question;

	// KHOI TAO
	public Exam(int id, String code, String title, CategoryQuestion categoryQuestion, String duration,
			Account creatorExam, String createDate) {
		super();
		this.id = id;
		this.code = code;
		this.title = title;
		this.categoryQuestion = categoryQuestion;
		this.duration = duration;
		this.creatorExam = creatorExam;
		this.createDate = createDate;
	}
	
	public Exam(int id, String code, String title, CategoryQuestion categoryQuestion, String duration,
			Account creatorExam, String createDate, Question questionSinger) {
		super();
		this.id = id;
		this.code = code;
		this.title = title;
		this.categoryQuestion = categoryQuestion;
		this.duration = duration;
		this.creatorExam = creatorExam;
		this.createDate = createDate;
		this.questionSinger = questionSinger;
	}
	
	public Exam(int id, String code, String title, CategoryQuestion categoryQuestion, String duration,
			Account creatorExam, String createDate, Question[] question) {
		super();
		this.id = id;
		this.code = code;
		this.title = title;
		this.categoryQuestion = categoryQuestion;
		this.duration = duration;
		this.creatorExam = creatorExam;
		this.createDate = createDate;
		this.question = question;
	}

	public Exam() {
		super();
	}

	// PHUONG THUC
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public CategoryQuestion getCategoryQuestion() {
		return categoryQuestion;
	}

	public void setCategoryQuestion(CategoryQuestion categoryQuestion) {
		this.categoryQuestion = categoryQuestion;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public Account getCreatorExam() {
		return creatorExam;
	}

	public void setCreatorExam(Account creatorExam) {
		this.creatorExam = creatorExam;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public Question[] getQuestion() {
		return question;
	}

	public void setQuestion(Question[] question) {
		this.question = question;
	}

	@Override
	public String toString() {
		return "Exam [id=" + id + ", code=" + code + ", title=" + title + ", categoryQuestion=" + categoryQuestion
				+ ", duration=" + duration + ", creatorExam=" + creatorExam + ", createDate=" + createDate
				+ ", question=" + Arrays.toString(question) + "]";
	}

}
