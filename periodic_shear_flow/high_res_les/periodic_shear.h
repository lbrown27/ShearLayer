#include "padelibs.h"
#include <vector>
#include <string>

using namespace plib;

class PeriodicShear {
  public:
    PeriodicShear(const int);
    virtual ~PeriodicShear();
    virtual void calcRHS(std::vector<Field>&, const std::vector<Field>&, const Real);
    virtual void timeAdvance(const Real);
    TimeIntegrator<PeriodicShear> time_integrator;
    virtual void solve();
    virtual void calcEddyDiffusivities () = 0;

  protected:
    std::vector<std::vector<Field> > cons_vars;
    std::vector<Field> primitive_vars;
    Field eddy_viscosity, eddy_conductivity;
    Real p_avg, force_amp, gamma, R;
    const int num_rans_eqns;
    Real dt;
};


/*!
 * Constructor
 * Arguments:
 * n [in] number of RANS model equations
 */
inline PeriodicShear::PeriodicShear(const int n) : num_rans_eqns(n) {
        //------------------------------//
        //-- Set time stepping method --//
        //------------------------------//
        int NUM_TIME_STEPPING_REGISTERS;
        std::string time_integrator_label = getItemFromConfigList<std::string>("NUMERICS", "integrator");
        print("Configure Time Advancement Integrator:\n");
        std::transform(time_integrator_label.begin(), time_integrator_label.end(), time_integrator_label.begin(), [](unsigned char c){ return std::toupper(c); });
        if        ( time_integrator_label.compare("RK4") == 0 ) {
            this->time_integrator = &RK4;
            NUM_TIME_STEPPING_REGISTERS = 4;
            print("    Standard RK4\n");
        } else if ( time_integrator_label.compare("SSPRK4") == 0 ) {
            this->time_integrator = &SSPRK4;
            NUM_TIME_STEPPING_REGISTERS = 4;
            print("    Strong Stability Preserving (SSP) RK4 (5 stages)\n");
        } else if ( time_integrator_label.compare("SSPRK3") == 0 ) {
            this->time_integrator = &SSPRK3;
            NUM_TIME_STEPPING_REGISTERS = 3;
        } else if ( time_integrator_label.compare("LDDRK4") == 0 ) {
            this->time_integrator = &LDDRK4;
            NUM_TIME_STEPPING_REGISTERS = 3;
            print("    Low-Dssipation and Low-Dispersion (LDD) RK4 (6 stages)\n");
        } else if ( time_integrator_label.compare("USER DEFINED") == 0 ) {
            print("    User defined.\n");
        } else {
            throw std::runtime_error("Ooooops! Time integrator is unknown!  -_-|||\n");
        }

    // Allocate buffers
    const int num_vars = this->num_rans_eqns + 2;
    this->cons_vars.resize(NUM_TIME_STEPPING_REGISTERS);
    for (int i=0; i<NUM_TIME_STEPPING_REGISTERS; i++) {
        this->cons_vars[i].resize(num_vars);
        for (auto it=this->cons_vars[i].begin(); it!=this->cons_vars[i].end(); it++) allocFieldTo3D(*it, "Evolution variables");
    }

    for (auto it=this->primitive_vars.begin(); it!=this->primitive_vars.end(); it++) allocFieldTo3D(*it, "Primitive variables");

    allocFieldTo3D(this->eddy_viscosity,    "Eddy viscosity");
    allocFieldTo3D(this->eddy_conductivity, "Eddy conductivity");
}


/*!
 * Destructor
 */
inline PeriodicShear::~PeriodicShear() {/* This function body is empty */}


/*!
 * Calculate RHS of evolution equations.
 */
inline void PeriodicShear::calcRHS(std::vector<Field>& ddt, const std::vector<Field>& cons_vars_now, const Real t) {
    (void) ddt; (void) cons_vars_now; (void) t; // TODO: finish implementation and delete this line.
}


/*!
 * Integrate from tn to tn + dt
 */
inline void PeriodicShear::timeAdvance(const Real t) {
    this->time_integrator(this->cons_vars, t, this->dt, this, &PeriodicShear::calcRHS, range_3d_all);
}


/*!
 * Solve
 */
inline void PeriodicShear::solve() {
    // TODO
    print("Simulation start!\n");
    print("Simulation done!\n");
}
