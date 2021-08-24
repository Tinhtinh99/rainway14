
public class CategoryQuestion {
	int id;
	categoryName categoryName;

	// KHOI TAO
	public CategoryQuestion(int id, categoryName categoryName) {
		super();
		this.id = id;
		this.categoryName = categoryName;
	}

	public CategoryQuestion() {
		super();
	}

	// PHUONG THUC
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public categoryName getcategoryName() {
		return this.categoryName;
	}

	public void setCategoryName(categoryName categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		String t = "CategoryQuestion	[id = " + this.id + "Name =" + this.categoryName + "]";
		return t;
	}

}
