# Somata clustering metrics

If you use this code, please cite our paper "Optimizing the in vitro neuronal microenvironment to mitigate phototoxicity in live-cell imaging" (https://doi.org/10.1186/s13287-025-04591-0).

Somata clustering metrics characterise the degree to which somata/nuclei coalesce into groups over time. Here they have been used to quantify neuron somata self-organising in vitro, imaged with widefield microscopy. The two metrics are:

- The Cluster Density Factor (CDF), which captures the compactness of aggregated somata clusters. The CDF equation is a ratio of the amount of somata at the initial timepoint to the total perimeter of somata at timepoint n. A high CDF usually represents cultures with dense clusters, while a low CDF usually denotes cultures that have a loose somata distribution.

- The Disaggregation index (DI), which captures the level to which somata are individuated or localised into small groups. The DI equation compares the total somata area at timepoint n to the initial timepoint. A high DI usually signifies that cells are either highly individuated, or assembled into small and relatively uniform clusters across the field of view. A low DI usually confers that cells have migrated into regional clusters.

<img width="798" height="741" alt="Screenshot 2026-04-05 at 8 39 09 pm" src="https://github.com/user-attachments/assets/63ae05bb-7960-4c32-9636-0fba097ad5a6" />



Inputs of the workflow are 2D live cell images acquired over time, which can either be raw or pre-segmented to define somata/nuclei. Outputs are csv files of DI and CDF metrics. At the start of DI processing, the user must determine the average soma size at timepoint 1 by defining a circular ROI (with oval selection tool) representative of a typical-sized soma.

  <img width="712" height="628" alt="Screenshot 2026-04-05 at 8 35 59 pm" src="https://github.com/user-attachments/assets/aa2858a1-5284-4516-b97e-e97657428f16" />

