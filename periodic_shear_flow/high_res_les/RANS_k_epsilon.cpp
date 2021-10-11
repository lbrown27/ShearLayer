/*!
 * File: RANS_k_epsilon.cpp
 * This file solves the compressible periodic shear flow using k-epsilon model.
 */
#include <cstdio>
#include "padelibs.h"
#include "periodic_shear.h"

class PeriodicShearKEpsilon : public PeriodicShear {

  public:
    /*!
     * Constructor
     */
    PeriodicShearKEpsilon() : PeriodicShear(2) {
        print("Periodic compressible turbulent shear flow using k-epsilon model.\n");
        // TODO: initlaize k-epsilon model coefficients

        print("Model Coefficients:\n");
        print("   C1 = %.5E\n", 1.0);
        print("   C2 = %.5E\n", 1.0);
        print("   C3 = %.5E\n", 1.0);
        print("   C4 = %.5E\n", 1.0);

        print("Forcing configuration:");
        print("   Amplitude: %.5E\n", 1.0);
    }


    /*!
     * Destructor
     */
    ~PeriodicShearKEpsilon() { /* Function body is empty */ }


    /*
     * Calculate RHS
     */
    virtual void calcRHS(std::vector<Field>& ddt, const std::vector<Field>& cons_vars_now, const Real t) override {
        PeriodicShear::calcRHS(ddt, cons_vars_now, t);
        // TODO: add k equation and epsilon equation here.
    }

    /*!
     * Calculate \mu_T and \kappa_T
     */
    virtual void calcEddyDiffusivities () override {
        Field mu  = this->eddy_viscosity;
        Field kap = this->eddy_conductivity;
        (void) mu; (void) kap; // TODO: finish implementation and delete this line.
    }
};

int main(int argc, char* argv[]) {
    plib::initialize(argc, argv);
{
    plib::PARTITION.reportInfo();
    PeriodicShearKEpsilon solver;
    solver.solve();
}
    return plib::finalize();
}
