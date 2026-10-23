module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.282000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-1.235700e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<-81> : tensor<3x8x7x4xi16>}> : () -> tensor<3x8x7x4xi16>
    %3 = "tosa.const"() <{values = dense<95> : tensor<1x1x1x1xi16>}> : () -> tensor<1x1x1x1xi16>
    %c1 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %a1 = tosa.maximum %0, %c1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %c2 = "tosa.const"() <{values = dense<1.0> : tensor<f32>}> : () -> tensor<f32>
    %a2 = tosa.maximum %1, %c2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = tosa.pow %a1, %a2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.bitwise_xor %2, %3 : (tensor<3x8x7x4xi16>, tensor<1x1x1x1xi16>) -> tensor<3x8x7x4xi16>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<3x8x7x4xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}