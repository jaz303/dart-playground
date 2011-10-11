class Vec2
{
	// final denotes constant
	final num EPSILON = 0.00001;

	// default constructor - note the lack of a function body and the use of "this";
	// causes parameters to be assigned directly to object fields
	Vec2(num this.x, num this.y);
	
	// this is a named constructor, it is called by "new Vec2.zero()"
	// this is also a redirecting constructor - it simply becomes new Vec2(0, 0)
	// we could also have done: "Vec2.zero() { x = 0; y = 0; }"
	Vec2.zero() : this(0, 0);
	
	// operator overloading for standard vector ops
	
	Vec2 operator+(Vec2 rhs) => new Vec2(x + rhs.x, y + rhs.y);
	Vec2 operator-(Vec2 rhs) => new Vec2(x - rhs.x, y - rhs.y);
	Vec2 operator*(num rhs) => new Vec2(x * rhs, y * rhs);
	Vec2 operator/(num rhs) => new Vec2(x / rhs, y / rhs);
	
	// unary minus can be overloaded too
	Vec2 operator negate() => new Vec(-x, -y);
	
	// equality operator
	// this is invoked when comparing using "=="
	// (Dart reserves === solely for comparing object identity and accordingly cannot be overloaded)
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