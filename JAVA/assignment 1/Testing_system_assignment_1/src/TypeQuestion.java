
public class TypeQuestion {
	int id;
	String name;

	// KHOI TAO
	public TypeQuestion(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public TypeQuestion() {
		super();
	}

	// PHUONG THUC
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	// toString
	@Override
	public String toString() {
		return "TypeQuestion [id=" + id + ", name=" + name + "]";
	}

}
