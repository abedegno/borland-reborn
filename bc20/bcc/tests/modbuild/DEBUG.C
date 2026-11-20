/* modtest: -ml -v -O -G */
/* Debug information (-v): globals and locals of many types, typedefs, enumerations,
   structures, unions, arrays, pointers, functions and nested scopes. */
typedef unsigned char byte;
typedef struct node { struct node *next; int key; char name[10]; } Node;
enum color { red, green = 5, blue };
union value { int i; long l; float f; double d; char *s; };
struct bits { unsigned a : 3; int b : 5; };
static Node nodes[4];
union value values[2];
enum color favourite = blue;
struct bits flags;
byte buffer[16];
char far *far_name;
int (*handler)(int, char *);
long double precise;
static int counter;
int lookup(Node *list, int key)
{
    register int steps = 0;
    Node *p;
    for (p = list; p; p = p->next) {
        byte mark = (byte)steps;
        if (p->key == key) {
            static int found;
            union value v;
            v.i = key;
            found++;
            return steps + mark + v.i + found;
        }
        steps++;
    }
    {
        enum color c = green;
        struct bits local = flags;
        counter += c + local.b;
    }
    return -1;
}
