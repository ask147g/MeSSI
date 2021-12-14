/*
Course project discipline "Interdisciplinary Project"
*/

#include <iostream>
#include <fstream>
#include "math.h"

const double T = 15; // Celsius
const double CW = 0.9;
const double CF = 0.925;
const double CP = 0.995;
const double r = 0.5; // per cents
const double N = 20;
double P = 150; // kg per year


int main()
{
	std::cout << "Calculations start" << std::endl;
    std::cout << std::endl;
	const double mu = (CP*7.0+(1-CP)*6.0)*pow(10, -3);
    P = P/mu/(365.0*24.0); // mol per hour
    double e = 4755.0/pow((T+273), 2) - 0.803 / (T+273);
    double nE = 2.0/e*log(CP*(1.0-CF)/(CF*(1.0-CP))); nE = ceil(nE);
    double nR = 2.0/e*log(CF*(1.0-CW)/(CW*(1.0-CF))); nR = ceil(nR);
    double nB = nE + nR;
    const int Nc = ceil(nB/N);

    double dN[Nc];
    for (int i = 0; i < Nc; i++)
    {
        dN[i] = i+1;
    } 

    double dC1[Nc+1]; dC1[0] = CW;
    double dC2[Nc+1]; dC2[Nc] = CP;
    
    // without P
    for (int i = 1; i < Nc; i++)
    {
        dC1[i] = (CW/(1-CW)*exp(e*i*N)) / (1.0 + CW/(1-CW)*exp(e*i*N));
    }

    // with P
    double Lb[Nc];
    double Le[Nc];
    double L[Nc];

    double Lin = 2.0*P*(CP-CF)/(e*CF*(1.0-CF));
    for (int i = 0; i < Nc; i++)
    {
        Lb[i] = Lin * pow((1.0-r/100.0), N*i);
        Le[i] = Lin * pow((1.0-r/100.0), N*(i+1));
        L[i] = (Lb[i] + Le[i]) / 2.0;
    }

    double x1, x2;
    for (int i = 0; i < Nc; i++)
    {
        x1 = 0.5 * (1.0 + P/(e*L[i])) + sqrt(0.25*(pow(1.0 + P/(e*L[i]), 2.0)) - P * CP / (e*L[i]));
        x2 = 0.5 * (1.0 + P/(e*L[i])) - sqrt(0.25*(pow(1.0 + P/(e*L[i]), 2.0)) - P * CP / (e*L[i]));
        dC2[i] = (x2 * (x1 - CP) / (CP - x2) * exp(e*(Nc-i)*N*(x1 - x2)) + x1) / (1 + (x1 - CP) / (CP - x2) * exp(e*(Nc-i)*N*(x1 - x2)));
    }

    // changing Lin
    double dh = 0.0001;
    int k = 0;
    while (abs(dC2[0]-CW) > 0.00009)
    {
        Lin = 2.0*P*(CP-CF)/(e*CF*(1.0-CF));
        Lin = Lin * (1-k*dh);
        for (int i = 0; i < Nc; i++)
        {
            Lb[i] = Lin * pow((1.0-r/100.0), N*i);
            Le[i] = Lin * pow((1.0-r/100.0), N*(i+1));
            L[i] = (Lb[i] + Le[i]) / 2.0;
        }

        x1, x2;
        for (int i = 0; i < Nc; i++)
        {
            x1 = 0.5 * (1.0 + P/(e*L[i])) + sqrt(0.25*(pow(1.0 + P/(e*L[i]), 2.0)) - P * CP / (e*L[i]));
            x2 = 0.5 * (1.0 + P/(e*L[i])) - sqrt(0.25*(pow(1.0 + P/(e*L[i]), 2.0)) - P * CP / (e*L[i]));
            dC2[i] = (x2 * (x1 - CP) / (CP - x2) * exp(e*(Nc-i)*N*(x1 - x2)) + x1) / (1 + (x1 - CP) / (CP - x2) * exp(e*(Nc-i)*N*(x1 - x2)));
        }
        k++;

        if (1 - k*dh < 0)
        {
            std::cout << "Error, too much increasion Lin: 1-k*dh < 0" << std::endl;
            break;
        }
    }

    // output into terminal
    std::cout<< "Lin is increased in " << 1 - k*dh << std::endl;
    std::cout << std::endl;
    std::cout << "N " << "L, mol/h  " << "C1    " << "C2" << std::endl;
    std::cout << dN[0] << " " << "- " <<  dC1[0] << "   " << dC2[0] << std::endl;
    for (int i = 1; i < Nc; i++)
    {
        std::cout << dN[i] << " " << L[i-1] << "    " <<  dC1[i] << "   " << dC2[i] << std::endl;
    } 

    // output into file
    std::ofstream out("output.txt", std::ios_base::out | std::ios_base::trunc);
    if (!out.is_open())
    {
        std::cout << "Error, file is not able to open" << std::endl;
    }
    else
    {
        out<< "Lin is increased in " << 1 - k*dh << std::endl;
        out << std::endl;
        out << "N   " << "L, mol/h  " << "C1    " << "C2" << std::endl;
        out << dN[0] << " " << "- " <<  dC1[0] << "   " << dC2[0] << std::endl;
        for (int i = 1; i < Nc; i++)
        {
            out << dN[i] << " " << L[i-1] << "    " <<  dC1[i] << "   " << dC2[i] << std::endl;
        } 
    }

    std::cout << std::endl;
    std::cout << "Calculations end" << std::endl;
	return 0;
}
