module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.698000e+02> : tensor<8x10xf32>}> : () -> tensor<8x10xf32>
    %1 = "tosa.const"() <{values = dense<-3> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<3> : tensor<i8>}> : () -> tensor<i8>
    %3 = tosa.ceil %0 : (tensor<8x10xf32>) -> tensor<8x10xf32>
    %4 = tosa.clamp %3 {max_val = 1.150000e+02 : f32, min_val = 6.200000e+01 : f32} : (tensor<8x10xf32>) -> tensor<8x10xf32>
    %5 = tosa.bitwise_or %1, %2 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %6 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<8x10xf32>) -> tensor<1x10xf32>
    %cast = tensor.cast %5 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<1x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

