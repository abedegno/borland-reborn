// modtest: -ml -v -O -G
// Debug information for C++ (-v): classes with base classes, virtual functions, static and
// member function members, member pointers, references, enumerations in classes.
class Shape {
public:
    enum Kind { circle, square };
    Shape(Kind k) : kind(k) {}
    virtual ~Shape() {}
    virtual long area() const = 0;
    Kind kind;
    static int made;
};
int Shape::made;
class Circle : public Shape {
public:
    Circle(int r) : Shape(circle), radius(r) { ++made; }
    long area() const { return 3L * radius * radius; }
    int radius;
};
struct Pair { int first; long second; Pair &self() { return *this; } };
int Circle::*radius_member = &Circle::radius;
long (Shape::*area_method)() const = &Shape::area;
long measure(Shape &s, Pair &p)
{
    Circle c(2);
    Circle &ref = c;
    Pair copy = p.self();
    int Pair::*field = &Pair::first;
    return (s.*area_method)() + ref.*radius_member + copy.*field + ref.area();
}
