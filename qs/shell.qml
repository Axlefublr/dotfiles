import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Widgets

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 25

  Item {
    MarginWrapperManager { margin: 5 }

    // Automatically detected by MarginWrapperManager as the
    // primary child of the container and sized accordingly.
    Rectangle {
      implicitWidth: 50
      implicitHeight: 50
    }
  }

}
