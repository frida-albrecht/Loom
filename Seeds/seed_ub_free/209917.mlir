module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-73> : tensor<3x1x2xi16>}> : () -> tensor<3x1x2xi16>
    %1 = "tosa.const"() <{values = dense<-140> : tensor<3x6x2xi16>}> : () -> tensor<3x6x2xi16>
    %2 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<3x1x2xi16>, tensor<3x6x2xi16>) -> tensor<3x7x2xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.negate %2, %3, %4 : (tensor<3x7x2xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<3x7x2xi16>
    %cast = tensor.cast %5 : tensor<3x7x2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

