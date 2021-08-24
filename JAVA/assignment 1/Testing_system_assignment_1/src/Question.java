
public class Question {
	int id;
	String content;
	CategoryQuestion categoryQuestion;
	TypeQuestion typeQuestion;
	Account creatorQuestion;
	String createDate;

	// KHOI TAO
	public Question(int id, String content, CategoryQuestion categoryQuestion, TypeQuestion typeQuestion,
			Account creatorQuestion, String createDate) {
		this.id = id;
		this.content = content;
		this.categoryQuestion = categoryQuestion;
		this.typeQuestion = typeQuestion;
		this.creatorQuestion = creatorQuestion;
		this.createDate = createDate;
	}

	public Question() {
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

	public CategoryQuestion getCategoryQuestion() {
		return categoryQuestion;
	}

	public void setCategoryQuestion(CategoryQuestion categoryQuestion) {
		this.categoryQuestion = categoryQuestion;
	}

	public TypeQuestion getTypeQuestion() {
		return typeQuestion;
	}

	public void setTypeQuestion(TypeQuestion typeQuestion) {
		this.typeQuestion = typeQuestion;
	}

	public Account getCreatorQuestion() {
		return creatorQuestion;
	}

	public void setCreatorQuestion(Account creatorQuestion) {
		this.creatorQuestion = creatorQuestion;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return "Question [id=" + id + ", content=" + content + ", categoryQuestion=" + categoryQuestion
				+ ", typeQuestion=" + typeQuestion + ", creatorQuestion=" + creatorQuestion + ", createDate="
				+ createDate + "]";
	}

}
