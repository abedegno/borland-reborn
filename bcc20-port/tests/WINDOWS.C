/* modtest: -ml -W -Fc */
/* Windows code (-W) and communal variables (-Fc): tentative definitions placed later, and
   COMDEFs.  A block-scope extern for a global, a function's multiple declaration, a type
   that is not allowed. */
int tentative;
int tentative;
char buffer[100];
long communal_long;
double communal_double;
struct big { char c[300]; } big_one;
int g(void);
int g(void);
int (*bad_array_of_functions)[3](void);
int use(void)
{
    extern int tentative;
    extern int later;
    return tentative + later + buffer[2];
}
