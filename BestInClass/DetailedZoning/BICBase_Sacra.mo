within BestInClass.DetailedZoning;
model BICBase_Sacra
  extends Modelica.Icons.Example;
  extends BaseClasses.PartialOpenLoop(par(
      idfFile=
          "modelica://BestInClass/Resources/idf/MediumOfficeDetailed_2004_sacramento.idf",
      weaFile=
          "modelica://BestInClass/Resources/weather/USA_CA_Sacramento.Metro.AP.724839_TMY3.mos",
      minAirFra=0.3),
      occupancy(period(displayUnit="s")),
    Building(zoneVAV7(zon(vol(fluidVolume=204.21*10)))),
    Building(zoneVAV8(zon(vol(fluidVolume=204.21*10)))),
    AHU(TSupSetHea(k=273.15 + 10)),
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
      StopTime=16502400,
      Interval=599.999616,
      __Dymola_Algorithm="Cvode"),
    __Dymola_Commands(
    file= "modelica://BestInClass/Resources/Script/DetailedZoning/SAC_Summer.mos"
        "SAC_Summer",
    file= "modelica://BestInClass/Resources/Script/DetailedZoning/SAC_Winter.mos"
        "SAC_Winter"));
end BICBase_Sacra;
