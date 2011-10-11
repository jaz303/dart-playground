class Vec2
{
	final num EPSILON = 0.00001;

	Vec2(num this.x, num this.y);
	Vec2.zero() { x = 0.0; y = 0.0; }
	
	Vec2 operator+(Vec2 rhs) {
		return new Vec2(x + rhs.x, y + rhs.y);
	}

	num x, y;
}

main() {

	Vec2 up = new Vec2(0, 1);

	Vec2 zero = new Vec2.zero();

}