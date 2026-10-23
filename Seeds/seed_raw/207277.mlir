module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<45> : tensor<2x3x9xi16>}> : () -> tensor<2x3x9xi16>
    %1 = "tosa.const"() <{values = dense<-37> : tensor<1x1x1xi16>}> : () -> tensor<1x1x1xi16>
    %2 = "tosa.const"() <{values = dense<1.847000e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.add %0, %1 : (tensor<2x3x9xi16>, tensor<1x1x1xi16>) -> tensor<2x3x9xi16>
    %4 = tosa.add %3, %3 : (tensor<2x3x9xi16>, tensor<2x3x9xi16>) -> tensor<2x3x9xi16>
    %5 = tosa.bitwise_xor %4, %3 : (tensor<2x3x9xi16>, tensor<2x3x9xi16>) -> tensor<2x3x9xi16>
    %6 = tosa.sigmoid %2 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.sub %6, %6 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %8 = tosa.logical_left_shift %5, %3 : (tensor<2x3x9xi16>, tensor<2x3x9xi16>) -> tensor<2x3x9xi16>
    %cast = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x3x9xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

