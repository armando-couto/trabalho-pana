include Java

require_relative 'libs/miglayout15-swing.jar'
require_relative 'libs/gnujaxp.jar'
require_relative 'libs/hamcrest-core-1.3.jar'
require_relative 'libs/iText-2.1.5.jar'
require_relative 'libs/jcommon-1.0.23.jar'
require_relative 'libs/jfreechart-1.0.19.jar'
require_relative 'libs/jfreechart-1.0.19-experimental.jar'
require_relative 'libs/jfreechart-1.0.19-swt.jar'
require_relative 'libs/jfreesvg-2.0.jar'
require_relative 'libs/orsoncharts-1.4-eval-nofx.jar'
require_relative 'libs/orsonpdf-1.6-eval.jar'
require_relative 'libs/swtgraphics2d.jar'

import java.lang.Math

import java.awt.Panel
import java.awt.Dimension
import java.awt.event.ActionEvent
import java.awt.event.ActionListener
import java.awt.event.KeyEvent

import javax.swing.ButtonGroup
import javax.swing.JFrame
import javax.swing.JLabel
import javax.swing.JOptionPane
import javax.swing.JRadioButton
import javax.swing.JTabbedPane

import org.jfree.chart.ChartFactory
import org.jfree.chart.ChartPanel
import org.jfree.chart.JFreeChart
import org.jfree.chart.plot.PlotOrientation
import org.jfree.data.xy.XYDataset
import org.jfree.data.xy.XYSeries
import org.jfree.data.xy.XYSeriesCollection
import org.jfree.ui.ApplicationFrame
import org.jfree.ui.RefineryUtilities

import javax.swing.JCheckBox
import javax.swing.JButton
import javax.swing.JTextField
import javax.swing.JPanel
import java.awt.Color

#  jruby trabalho1.rb && jruby -e "load 'trabalho1.class'"

class App < JFrame

  def initialize
    super("Trabalho")
    initComponents
  end

  private
  def initComponents
    cbox_op1 = JCheckBox.new("f(n)=n")
    cbox_op1.setBounds(83, 7, 97, 23)
    cbox_op2 = JCheckBox.new("f(n)=n²")
    cbox_op2.setBounds(83, 33, 97, 23)
    cbox_op3 = JCheckBox.new("f(n)=2ˆn")
    cbox_op3.setBounds(83, 59, 97, 23)
    cbox_op4 = JCheckBox.new("f(n)=nlogn")
    cbox_op4.setBounds(83, 84, 97, 23)
    cbox_op5 = JCheckBox.new("f(n)=logn")
    cbox_op5.setBounds(83, 110, 97, 23)
    cbox_op6 = JCheckBox.new("f(n)=n!")
    cbox_op6.setBounds(83, 136, 97, 23)
    cbox_op7 = JCheckBox.new("f(n)=1")
    cbox_op7.setBounds(83, 163, 97, 23)
    cbox_op8 = JCheckBox.new("f(n)=nˆn")
    cbox_op8.setBounds(83, 193, 97, 23)
    cbox_op9 = JCheckBox.new("f(n)=loglogn")
    cbox_op9.setBounds(83, 223, 97, 23)
    textField_n= JTextField.new
    textField_n.setColumns(10)
    textField_n.setBounds(83, 243, 97, 23)
    btnGerar = JButton.new("MONTAR")
    btnGerar.setBounds(247, 243, 97, 23)

    panel_exercicio= mount cbox_op1, cbox_op2, cbox_op3, cbox_op4, cbox_op5, cbox_op6, cbox_op7, cbox_op8, cbox_op9, textField_n, btnGerar

    btnGerar.add_action_listener do |evt|
      panel_exercicio= mount cbox_op1, cbox_op2, cbox_op3, cbox_op4, cbox_op5, cbox_op6, cbox_op7, cbox_op8, cbox_op9, textField_n, btnGerar
      self.setContentPane(panel_exercicio)
      self.setVisible(true)
    end

    # Show frame
    self.setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)
    self.setBounds(100, 100, 1024, 768)
    self.setContentPane(panel_exercicio)
    self.setVisible(true)
  end

  def mount cbox_op1, cbox_op2, cbox_op3, cbox_op4, cbox_op5, cbox_op6, cbox_op7, cbox_op8, cbox_op9, textField_n, btnGerar
    pieChart= ChartFactory.createXYLineChart("Grafico", "X", "Y", createDataset(cbox_op1, cbox_op2, cbox_op3, cbox_op4, cbox_op5, cbox_op6, cbox_op7, cbox_op8, cbox_op9, textField_n), PlotOrientation::VERTICAL, true, true, false)
    chart_panel = ChartPanel.new(pieChart)
    chart_panel.setBounds(73, 273, 703, 309)
    chart_panel.setPreferredSize(Dimension.new(500, 500))

    panel_exercicio= Panel.new
    panel_exercicio.setLayout(nil)

    panel_exercicio.add(chart_panel)
    panel_exercicio.add(cbox_op1)
    panel_exercicio.add(cbox_op2)
    panel_exercicio.add(cbox_op3)
    panel_exercicio.add(cbox_op4)
    panel_exercicio.add(cbox_op5)
    panel_exercicio.add(cbox_op6)
    panel_exercicio.add(cbox_op7)
    panel_exercicio.add(cbox_op8)
    panel_exercicio.add(cbox_op9)
    panel_exercicio.add(textField_n)
    panel_exercicio.add(btnGerar)
    panel_exercicio.validate
    panel_exercicio.repaint
    panel_exercicio
  end

  def createDataset cbox_op1, cbox_op2, cbox_op3, cbox_op4, cbox_op5, cbox_op6, cbox_op7, cbox_op8, cbox_op9, textField_n
    dataset = XYSeriesCollection.new
    entrada= textField_n.text.to_i

    if cbox_op1 != nil && cbox_op1.isSelected
      op1 = XYSeries.new("f(n)=n")
      (0 .. entrada).each { |x| op1.add(x, x) }
      dataset.addSeries(op1)
    end

    if cbox_op2 != nil && cbox_op2.isSelected
      op2= XYSeries.new("f(n)=n²")
      (0 .. entrada).each { |x| op2.add(x, x * x) }
      dataset.addSeries(op2)
    end

    if cbox_op3 != nil && cbox_op3.isSelected
      op3= XYSeries.new("f(n)=2ˆn")
      (0 .. entrada).each { |x| op3.add(x, Math.pow(2, x)) }
      dataset.addSeries(op3)
    end

    if cbox_op4 != nil && cbox_op4.isSelected
      op4= XYSeries.new("f(n)=nlogn")
      (1 .. entrada).each { |x| op4.add(x, x * Math.log10(x)) }
      dataset.addSeries(op4)
    end

    if cbox_op5 != nil && cbox_op5.isSelected
      op5 = XYSeries.new("f(n)=logn")
      (1 .. entrada).each { |x| op5.add(x, Math.log10(x)) }
      dataset.addSeries(op5)
    end

    if cbox_op6 != nil && cbox_op6.isSelected
      op6 = XYSeries.new("f(n)=n!")
      (1 .. entrada).each { |x| op6.add(x, fatorial(x)) }
      dataset.addSeries(op6)
    end

    if cbox_op7 != nil && cbox_op7.isSelected
      op7 = XYSeries.new("f(n)=1")
      (0 .. entrada).each { |x| op7.add(x, 1) }
      dataset.addSeries(op7)
    end

    if cbox_op8 != nil && cbox_op8.isSelected
      op8 = XYSeries.new("f(n)=n^n")
      (0 .. entrada).each { |x| op8.add(x, Math.pow(x, x)) }
      dataset.addSeries(op8)
    end

    if cbox_op9 != nil && cbox_op9.isSelected
      op9 = XYSeries.new("f(n)=loglogn")
      (1 .. entrada).each { |x| op9.add(x, Math.log10(Math.log10(x))) }
      dataset.addSeries(op9)
    end

    dataset
  end

  def fatorial n
    if n > 1
      return n * fatorial(n-1)
    else
      return 1
    end
  end
end

app = App.new
app.pack