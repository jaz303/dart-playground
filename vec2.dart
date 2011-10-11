class Vec2
{
	final num EPSILON = 0.00001;

	Vec2(num this.x, num this.y);
	Vec2.zero() : this(0, 0);
	
	Vec2 operator+(Vec2 rhs) => new Vec2(x + rhs.x, y + rhs.y);
	Vec2 operator-(Vec2 rhs) => new Vec2(x - rhs.x, y - rhs.y);
	Vec2 operator*(num rhs) => new Vec2(x * rhs, y * rhs);
	Vec2 operator/(num rhs) => new Vec2(x / rhs, y / rhs);
	
	Vec2 operator negate() => new Vec(-x, -y);
	
	bool operator==(Vec2 rhs) =>
		Math.abs(rhs.x - x) < EPSILON && Math.abs(rhs.y - y) < EPSILON;
	
	num mag() => Math.sqrt(x*x + y*y);
	num magsq() => x*x + y*y;
	
	num dot(rhs) => x*rhs.x + y*rhs.y;
	
	num normalized() { num mag = mag(); return new Vec2(x / mag, y / mag); }
	
	num x, y;
}

main() {

	Vec2 up = new Vec2(0, 1);

	Vec2 zero = new Vec2.zero();

}