
public class Group {
	int id;
	String name;
	Account createGroup;
	String createDate;
	Account[] member;
	String memberJoinDate;

	// KHOI TAO
	public Group(int id, String name, Account createGroup, String createDate, Account[] member, String memberJoinDate) {
		super();
		this.id = id;
		this.name = name;
		this.createGroup = createGroup;
		this.createDate = createDate;
		this.member = member;
		this.memberJoinDate = memberJoinDate;
	}

	public Group() {
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

	public Account getCreateGroup() {
		return createGroup;
	}

	public void setCreateGroup(Account createGroup) {
		this.createGroup = createGroup;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public Account[] getMember() {
		return member;
	}

	public void setMember(Account[] member) {
		this.member = member;
	}

	public String getMemberJoinDate() {
		return memberJoinDate;
	}

	public void setMemberJoinDate(String memberJoinDate) {
		this.memberJoinDate = memberJoinDate;
	}

	@Override
	public String toString() {
		return "Group [id=" + id + ", name=" + name + ", createGroup=" + createGroup + ", createDate=" + createDate
				+ ", member=" + member + ", memberJoinDate=" + memberJoinDate + "]";
	}

}
