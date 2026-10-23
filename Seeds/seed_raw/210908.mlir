module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<6xi8>}> : () -> tensor<6xi8>
    %1 = "tosa.const"() <{values = dense<-5.245000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.clamp %0 {max_val = -18 : i8, min_val = -48 : i8} : (tensor<6xi8>) -> tensor<6xi8>
    %3 = tosa.sigmoid %1 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.bitwise_and %2, %2 : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    %5 = tosa.maximum %4, %2 : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

