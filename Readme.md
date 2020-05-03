## Day Zero Simulator (COIVID-19)

Requires MATLAB R2020a

## THE GOAL OF THIS SIMULATION AND MODEL
The goal of this model is to predict how long it will take to return to life before a virus; the goal of zero infections, which will be referred to as "Day Zero". 
The effect of various strategies is analyzed with respect to the long term goal of reaching zero infection, that is not a single person infected and the virus has been completely extinguished.
The model considers the following strategies of eradicating a pathogen:
* Social Distancing
* Testing and Medical Quarantine
* Vaccination (not yet implemented)

Even if we had things like a vaccine today, it would still take time to immunize everyone given a finite rate of vaccination! 
* How long if we all locked ourselves in our homes with no interactions with others!? 
* Will it be possible to completely eliminate the virus? 
* What will happen if social distancing measures are stopped prematurely, will future outbreaks occur?


# Patient Model
| Name           | Type       | Values                                                                                                        |
|----------------|------------|---------------------------------------------------------------------------------------------------------------|
| eHealth        | Enumerated | Healthy- A person who is not infected                                                                         |
|                |            | Carrier - A person who is infected                                                                            |
|                |            | Deceased - A person who has died                                                                              |
|                |            | Immune - A healthy person who is immune.                                                                      |
|                |            |                                                                                                               |
| eQuarintined   | Enumerated | The level of isolation of a person. Each of these states have their own functions describing them             |
|                |            | None  - Normal interaction with others                                                                        |
|                |            | SocialyDistanced - Separated from others with a low transmission rate                                         |
|                |            | Medical - Isolation in a medical grade environment.  A very low rate of transmission to others                |
|                |            | Full - Zero interaction with others (For example if deceased)                                                 |
|                |            |                                                                                                               |
| isCarrier      | Boolean    | True - Is infected with virus                                                                                 |
|                |            | False - Is infected with virus                                                                                |
| isAsymptomatic | Boolean    | Asymptomatic carries are not detectable unless directly tested via a larger screening of ?Healty? Individuals |
|                |            | True - Infected but does not show symptoms                                                                    |
|                |            | False - Infected and shows symptoms                                                                           |
| isImmune       | Boolean    | Is the person immune to infection                                                                             |
|                |            | True - Person is immune                                                                                       |
|                |            | False - Person is not immune                                                                                  |
| tInfected      | Time       | The time a person has been infected.                                                                          |

# Events
| Name          | Description                                                          |
|---------------|----------------------------------------------------------------------|
| Infected      | Is the person contacted by someone with the virus and gets infected  |
| Immunized     | A healthy person can be immunized and gain immunity                  |
| GainsImmunity | recovery a person can become immune                                  |


# Statistical Parameters
| Name                | Type    | Values                                                                                                                                         |
|---------------------|---------|------------------------------------------------------------------------------------------------------------------------------------------------|
| probInfec           | Percent | The probability the person will be infected when contacted.                                                                                    |
|                     |         |                                                                                                                                                |
| probAsymptomatic    | Percent | The probability the person will be asymptomatic when infected.                                                                                 |
|                     |         |                                                                                                                                                |
| probDuration        | Percent | The probability of the time a person will be infected. If the duration exceeds defined length the person will die (unless a healthy carrier).  |
| probInnaiteImmunity | Percent | The probability a patient is immune (starting)                                                                                                 |
| probGainImmunity    | Percent | The probability a patient can gain immunity after infection                                                                                    |
| probVaccination     | Percent | The probability a patient gains immunity after vacination                                                                                      |
## Assumptions
* •	Terminal patients are always symptomatic



# Future Considerations

Superspreader – A patient who could spread to an unusually large number of other patients
Asymptomatic Carriers – Currently the model assumes this is a constant. It may be possible an individual responds differently to multiple exposures.
Region – Split patients into different regions allowing simulation of regional isolation

# Future properties

| iRegion | Integer | An integer value of the region a person is in. Regional quarantine allows no interaction between people outside of region |
|---------|---------|---------------------------------------------------------------------------------------------------------------------------|
