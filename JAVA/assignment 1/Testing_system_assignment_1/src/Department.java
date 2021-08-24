public class Department {
	int id;
	String name;

	// KHOI TAO
	public Department(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public Department() {
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
		return "Department [id=" + id + ", name=" + name + "]";
	}
}
