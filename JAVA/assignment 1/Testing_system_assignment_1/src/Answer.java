
public class Answer {
	int id;
	String content;
	Question[] question;
	AnswerRightWrong answerRightWrong;

	// KHOI TAO
	public Answer(int id, String content, Question[] question, AnswerRightWrong answerRightWrong) {
		this.id = id;
		this.content = content;
		this.question = question;
		this.answerRightWrong = answerRightWrong;
	}

	public Answer() {
		super();
	}
	// PHUONG THUC

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Question[] getQuestion() {
		return question;
	}

	public void setQuestion(Question[] question) {
		this.question = question;
	}

	public AnswerRightWrong getAnswerRightWrong() {
		return answerRightWrong;
	}

	public void setAnswerRightWrong(AnswerRightWrong answerRightWrong) {
		this.answerRightWrong = answerRightWrong;
	}
	// toString

	@Override
	public String toString() {
		return "Answer [id=" + id + ", content=" + content + ", question=" + question + ", answerRightWrong="
				+ answerRightWrong + "]";
	}

}
