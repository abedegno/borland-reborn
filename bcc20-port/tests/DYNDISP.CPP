// modtest: -ml
// Borland's dynamic dispatch numbers ("= [n]" after a member function), inherited by an
// override; old-style base initialisers with no name.
class Window {
public:
    virtual void paint() = [100];
    virtual void size(int) = [101];
};
class Button : public Window {
public:
    void paint();
    virtual void size(int) = [101];
};
void Button::paint() {}
void Button::size(int) {}
class Base { public: Base(int); };
class Derived : public Base { public: Derived() : (5) {} };
void use(Window *w) { w->paint(); w->size(3); }
