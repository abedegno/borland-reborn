#include <iostream.h>
class Shape {
public:
    Shape(int k) : kind(k) {}
    virtual ~Shape() {}
    virtual double area() const = 0;
    int kind;
};
class Rect : public Shape {
public:
    Rect(double w, double h) : Shape(1), w(w), h(h) {}
    double area() const { return w * h; }
private:
    double w, h;
};
inline int operator==(const Rect &a, const Rect &b) { return a.area() == b.area(); }
int main()
{
    Rect r(2, 3), s(3, 2);
    Shape *p = &r;
    cout << p->area() << " " << (r == s) << "\n";
    return 0;
}
