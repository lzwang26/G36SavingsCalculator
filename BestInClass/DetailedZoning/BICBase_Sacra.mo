within BestInClass.DetailedZoning;
model BICBase_Sacra
  extends Modelica.Icons.Example;
  extends BaseClasses.PartialOpenLoop(par(
      idfFile=
          "modelica://BestInClass/Resources/idf/EPlus/Validation/MediumOfficeDetailed_2004_sacramento_hvac.idf",
      weaFile=
          "modelica://BestInClass/Resources/weather/USA_CA_Sacramento.Metro.AP.724839_TMY3.mos",
      minAirFra=0.3,
      m_flow_zone=1.2*{0.058093,0.051786,0.05138,0.029099,0.437438,0.408337,
          0.299423,0.297499,0.080845,1.09,1,0.178495,0.173994,0.084635,0.650558,
          0.70973,0.700693,0.836196,0.11866,0.060594,0.057511},
      m_flow_sys=1.2*6.35),
      occupancy(occupancy=3600*{5.01667,21.01667},
      period(displayUnit="s") = 86400),
    Building(
    zoneVAV7(zon(vol(fluidVolume=204.21*10))),
    zoneVAV8(zon(vol(fluidVolume=118.25*10))),
    zoneVAV1(zon(T_start=24.4+273.15)),
    zoneVAV2(zon(T_start=24.27+273.15)),
    zoneVAV3(zon(T_start=24.26+273.15)),
    zoneVAV4(zon(T_start=24.72+273.15)),
    zoneVAV5(zon(T_start=27.58+273.15)),
    zoneVAV6(zon(T_start=27.2+273.15)),
    zoneVAV7(zon(T_start=25.7+273.15)),
    zoneVAV8(zon(T_start=25.66+273.15)),
    zoneVAV9(zon(T_start=25.46+273.15)),
    zoneVAV10(zon(T_start=27.61+273.15)),
    zoneVAV11(zon(T_start=26.96+273.15)),
    zoneVAV12(zon(T_start=26.53+273.15)),
    zoneVAV13(zon(T_start=24.78+273.15)),
    zoneVAV14(zon(T_start=24.19+273.15)),
    zoneVAV15(zon(T_start=25.96+273.15)),
    zoneVAV16(zon(T_start=25.95+273.15)),
    zoneVAV17(zon(T_start=26.58+273.15)),
    zoneVAV18(zon(T_start=26.65+273.15)),
    zoneVAV19(zon(T_start=24.94+273.15)),
    zoneVAV20(zon(T_start=24.8+273.15)),
    zoneVAV21(zon(T_start=24.49+273.15))),
    AHU(TSupSetHea(k=273.15 + 10),
    conEco(VOut_flow_min=0.7293),
      TRet(
        T_start=300.18,
        transferHeat=true,
        TAmb=296.6,
        tauHeaTra=10),
      fanSup(addPowerToMedium=false),
      TSup(
        transferHeat=true,
        TAmb=296.6,
        tauHeaTra=10)),
    internalGains(
      kLig=0,
      kEqu=0,
      gaiRadPeo(k=0),
      gaiConPeo(k=0),
      gaiLatPeo(k=0)));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant pSetDuc(k=par.pSetCon)
    "Duct static pressure setpoint"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant minAirFra(k=par.minAirFra)
    "Minimum zone airflow fraction"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Constant TSupSetCoo(y(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC",
      min=0), k=par.TSupSetCoo)
                             "Supply air temperature setpoint for cooling"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));

  Modelica.Blocks.Sources.CombiTimeTable datRea(
    final fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://BestInClass/Resources/idf/EPlus/Validation/MediumOfficeDetailed_2004_sacramento_hvac.dat"),
    final tableOnFile=true,
    final columns=2:45,
    final tableName="EnergyPlus",
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Reader for EnergyPlus example results"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));

  Modelica.Blocks.Continuous.Integrator ECoiEPlu(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Cooling coil energy consumption from EnergyPlus"
    annotation (Placement(transformation(extent={{138,40},{158,60}})));
  Modelica.Blocks.Sources.RealExpression PCoiEPlu(y=datRea.y[5]/3.2)
    "Cooling coil power consumption from EnergyPlus"
    annotation (Placement(transformation(extent={{104,40},{124,60}})));
  Modelica.Blocks.Continuous.Integrator ECoiESpa(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Cooling coil energy consumption from Spawn"
    annotation (Placement(transformation(extent={{138,10},{158,30}})));
  Modelica.Blocks.Sources.RealExpression PCoiSpa(y=AHU.cooCoi.Q1_flow/3.2)
    "Cooling coil power consumption from Spawn"
    annotation (Placement(transformation(extent={{104,10},{124,30}})));
  Modelica.Blocks.Continuous.Integrator EFanEPlu(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Fan energy consumption from EnergyPlus"
    annotation (Placement(transformation(extent={{140,-28},{160,-8}})));
  Modelica.Blocks.Sources.RealExpression PFanEPlu(y=datRea.y[44])
    "Fan power consumption from EnergyPlus"
    annotation (Placement(transformation(extent={{106,-28},{126,-8}})));
  Modelica.Blocks.Continuous.Integrator EFanESpa(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Fan energy consumption from Spawn"
    annotation (Placement(transformation(extent={{140,-58},{160,-38}})));
  Modelica.Blocks.Sources.RealExpression PFanSpa(y=AHU.fanSup.P)
    "Fan power consumption from Spawn"
    annotation (Placement(transformation(extent={{106,-58},{126,-38}})));
equation
  connect(pSetDuc.y,fanVFD.u)    annotation (Line(points={{-58,-10},{-22,-10}},
                                                                              color={0,0,127}));
  connect(TSupSetCoo.y, AHU.TSupSetCoo) annotation (Line(points={{-59,-40},{8,
          -40},{8,-7},{19,-7}}, color={0,0,127}));
  connect(minAirFra.y,Building.minAirFra)  annotation (Line(points={{-58,-70},{
          56,-70},{56,-15},{59,-15}}, color={0,0,127}));
  connect(weather.weaBus, AHU.weaBus) annotation (Line(
      points={{-60,50},{21.6,50},{21.6,-2}},
      color={255,204,51},
      thickness=0.5));
  connect(PCoiEPlu.y, ECoiEPlu.u)
    annotation (Line(points={{125,50},{136,50}}, color={0,0,127}));
  connect(PCoiSpa.y, ECoiESpa.u)
    annotation (Line(points={{125,20},{136,20}}, color={0,0,127}));
  connect(PFanEPlu.y, EFanEPlu.u)
    annotation (Line(points={{127,-18},{138,-18}}, color={0,0,127}));
  connect(PFanSpa.y, EFanESpa.u)
    annotation (Line(points={{127,-48},{138,-48}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false),
                    graphics={
        Line(points={{-142,48}}, color={28,108,200})}),
    experiment(
      StartTime=16329600,
      StopTime=17280000,
      Interval=599.999616,
      __Dymola_Algorithm="Cvode"),
    __Dymola_Commands(file=
          "modelica://BestInClass/Resources/Script/DetailedZoning/SAC_Summer.mos"
        "SAC_Summer", file=
          "modelica://BestInClass/Resources/Script/DetailedZoning/SAC_Winter.mos"
        "SAC_Winter"));
end BICBase_Sacra;
