within BestInClass.DetailedZoning;
model BICBase_Sacra
  extends Modelica.Icons.Example;
  extends BaseClasses.PartialOpenLoop(par(
      idfFile=
          "modelica://BestInClass/Resources/idf/MediumOfficeDetailed_2004_sacramento_hvac.idf",
      weaFile=
          "modelica://BestInClass/Resources/weather/USA_CA_Sacramento.Metro.AP.724839_TMY3.mos",
      minAirFra=0.3,
      m_flow_zone=1.2*{0.045544,0.040528,0.040357,0.022085,0.43118,0.398818,
          0.222669,0.222802,0.066113,1.07,0.986517,0.14797,0.149323,0.07028,
          0.493998,0.53816,0.59377,0.819185,0.097882,0.047462,0.045102},
      m_flow_sys=1.2*5.31),
      occupancy(occupancy=3600*{5.17,21.17}, period(displayUnit="s") = 86400),
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
      TRet(T_start=300.18),
      fanSup(addPowerToMedium=false)),
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
    final columns=2:29,
    final tableName="EnergyPlus",
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Reader for EnergyPlus example results"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));

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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false),
                    graphics={
        Line(points={{-142,48}}, color={28,108,200})}),
    experiment(
      StartTime=16329600,
      StopTime=16761600,
      Interval=599.999616,
      __Dymola_Algorithm="Cvode"),
    __Dymola_Commands(file=
          "modelica://BestInClass/Resources/Script/DetailedZoning/SAC_Summer.mos"
        "SAC_Summer", file=
          "modelica://BestInClass/Resources/Script/DetailedZoning/SAC_Winter.mos"
        "SAC_Winter"));
end BICBase_Sacra;
