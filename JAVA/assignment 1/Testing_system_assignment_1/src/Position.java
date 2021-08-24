
public class Position {
	int id;
	String name;

	// KHOI TAO
	public Position(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public Position() {
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
		return "Position [id=" + id + ", name=" + name + "]";
	}

}
