module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.550000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-1.503100e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<4> : tensor<8x9xi8>}> : () -> tensor<8x9xi8>
    %3 = tosa.pow %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = tosa.reduce_sum %2 {axis = 0 : i32} : (tensor<8x9xi8>) -> tensor<1x9xi8>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<1x9xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

