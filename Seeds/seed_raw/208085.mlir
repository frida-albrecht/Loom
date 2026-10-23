module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-26> : tensor<2xi16>}> : () -> tensor<2xi16>
    %1 = "tosa.const"() <{values = dense<142> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %2 = "tosa.const"() <{values = dense<8> : tensor<3x10xi8>}> : () -> tensor<3x10xi8>
    %3 = "tosa.const"() <{values = dense<9> : tensor<1x10xi8>}> : () -> tensor<1x10xi8>
    %4 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.pad %0, %4, %5 : (tensor<2xi16>, !tosa.shape<2>, tensor<1xi16>) -> tensor<2xi16>
    %7 = tosa.minimum %2, %3 : (tensor<3x10xi8>, tensor<1x10xi8>) -> tensor<3x10xi8>
    %8 = tosa.arithmetic_right_shift %6, %6 {round = false} : (tensor<2xi16>, tensor<2xi16>) -> tensor<2xi16>
    %cast = tensor.cast %7 : tensor<3x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<2xi16> to tensor<*xi16>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

