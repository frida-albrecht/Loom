module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-139> : tensor<6x7x9xi16>}> : () -> tensor<6x7x9xi16>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<6x7x1xi16>}> : () -> tensor<6x7x1xi16>
    %2 = "tosa.const"() <{values = dense<1.289900e+02> : tensor<9x1x5xf32>}> : () -> tensor<9x1x5xf32>
    %3 = tosa.add %0, %1 : (tensor<6x7x9xi16>, tensor<6x7x1xi16>) -> tensor<6x7x9xi16>
    %4 = tosa.ceil %2 : (tensor<9x1x5xf32>) -> tensor<9x1x5xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x7x9xi16>}> : () -> tensor<6x7x9xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<6x7x9xi16>}> : () -> tensor<6x7x9xi16>
    %a0 = tosa.maximum %3, %c0 : (tensor<6x7x9xi16>, tensor<6x7x9xi16>) -> tensor<6x7x9xi16>
    %a1 = tosa.minimum %a0, %c15 : (tensor<6x7x9xi16>, tensor<6x7x9xi16>) -> tensor<6x7x9xi16>
    %5 = tosa.arithmetic_right_shift %3, %a1 {round = false} : (tensor<6x7x9xi16>, tensor<6x7x9xi16>) -> tensor<6x7x9xi16>
    %cast = tensor.cast %4 : tensor<9x1x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6x7x9xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}