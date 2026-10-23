module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-44> : tensor<1x4xi16>}> : () -> tensor<1x4xi16>
    %1 = "tosa.const"() <{values = dense<-120> : tensor<1x1xi16>}> : () -> tensor<1x1xi16>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<1x4xi16>, tensor<1x1xi16>) -> tensor<1x4xi16>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = tosa.negate %2, %3, %4 : (tensor<1x4xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<1x4xi16>
    %cast = tensor.cast %5 : tensor<1x4xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

