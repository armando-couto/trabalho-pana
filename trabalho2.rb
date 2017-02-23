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

#  jruby trabalho1.rb && jruby -e "load 'trabalho2.class'"

class App < JFrame

  def initialize
    super("Trabalho")
    initComponents
  end

  private
  def initComponents
    textField_n= JTextField.new
    textField_n.setColumns(10)
    textField_n.setBounds(83, 10, 97, 23)
    btnGerar = JButton.new("MONTAR")
    btnGerar.setBounds(247, 10, 97, 23)

    panel_exercicio= mount textField_n, btnGerar

    btnGerar.add_action_listener do |evt|
      panel_exercicio= mount textField_n, btnGerar
      self.setContentPane(panel_exercicio)
      self.setVisible(true)
    end

    # Show frame
    self.setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)
    self.setBounds(100, 100, 1024, 768)
    self.setContentPane(panel_exercicio)
    self.setVisible(true)
  end

  def mount textField_n, btnGerar
    panel_exercicio= Panel.new
    panel_exercicio.setLayout(nil)

    pieChart1= ChartFactory.createXYLineChart("Insert Sort", "X", "Y", insertion_sort(textField_n), PlotOrientation::VERTICAL, true, true, false)
    chart_panel1 = ChartPanel.new(pieChart1)
    chart_panel1.setBounds(73, 53, 703, 309)
    chart_panel1.setPreferredSize(Dimension.new(500, 500))
    panel_exercicio.add(chart_panel1)

    pieChart2= ChartFactory.createXYLineChart("f(n)=n²", "X", "Y", createDataset(textField_n), PlotOrientation::VERTICAL, true, true, false)
    chart_panel2 = ChartPanel.new(pieChart2)
    chart_panel2.setBounds(73, 380, 703, 309)
    chart_panel2.setPreferredSize(Dimension.new(500, 500))
    panel_exercicio.add(chart_panel2)

    panel_exercicio.add(textField_n)
    panel_exercicio.add(btnGerar)
    panel_exercicio.validate
    panel_exercicio.repaint
    panel_exercicio
  end

  def createDataset textField_n
    dataset = XYSeriesCollection.new
    entrada= textField_n.text.to_i

    op= XYSeries.new("f(n)=n²")
    (0 .. entrada).each { |x| op.add(x, x * x) }
    dataset.addSeries(op)

    dataset
  end

  def insertion_sort textField_n
    dataset= XYSeriesCollection.new
    entrada= textField_n.text.to_i
    op= XYSeries.new("Insertion Sort")

    array= []
    (0 .. entrada).each do |x|
      xx= Random.rand(entrada+1)
      array[x]= xx
    end

    final = [array[0]]
    array.delete_at(0)
    # main code
    for i in array
      final_index = 0
      while final_index < final.length
        if i <= final[final_index]
          final.insert(final_index, i)
          op.add(i, final_index)
          break
        elsif final_index == final.length-1
          final.insert(final_index+1, i)
          op.add(i, final_index+i)
          break
        end
        final_index+=1
      end
    end
    dataset.addSeries(op)
    dataset
  end
end

app = App.new
app.pack