module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<26> : tensor<2xi16>}> : () -> tensor<2xi16>
    %1 = "tosa.const"() <{values = dense<1.623200e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<-8.329000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<2xi16>) -> tensor<1xi16>
    %4 = tosa.clamp %3 {max_val = -24 : i16, min_val = -48 : i16} : (tensor<1xi16>) -> tensor<1xi16>
    %5 = tosa.pow %1, %2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

