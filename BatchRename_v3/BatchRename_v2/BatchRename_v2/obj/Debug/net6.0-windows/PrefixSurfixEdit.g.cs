﻿#pragma checksum "..\..\..\PrefixSurfixEdit.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "7B933E1295FDCCB0A140733A6E64907D8218F93E"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using BatchRename_v2;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Controls.Ribbon;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace BatchRename_v2 {
    
    
    /// <summary>
    /// PrefixSurfixEdit
    /// </summary>
    public partial class PrefixSurfixEdit : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 25 "..\..\..\PrefixSurfixEdit.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.RadioButton prefixBtn;
        
        #line default
        #line hidden
        
        
        #line 28 "..\..\..\PrefixSurfixEdit.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.RadioButton surfixBtn;
        
        #line default
        #line hidden
        
        
        #line 30 "..\..\..\PrefixSurfixEdit.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox content;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "6.0.3.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/BatchRename_v2;component/prefixsurfixedit.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\PrefixSurfixEdit.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "6.0.3.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.prefixBtn = ((System.Windows.Controls.RadioButton)(target));
            return;
            case 2:
            this.surfixBtn = ((System.Windows.Controls.RadioButton)(target));
            return;
            case 3:
            this.content = ((System.Windows.Controls.TextBox)(target));
            return;
            case 4:
            
            #line 32 "..\..\..\PrefixSurfixEdit.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.applyButton);
            
            #line default
            #line hidden
            return;
            case 5:
            
            #line 34 "..\..\..\PrefixSurfixEdit.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.cancleButton);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

