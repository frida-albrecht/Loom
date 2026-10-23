module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-16> : tensor<5x2x8x9xi8>}> : () -> tensor<5x2x8x9xi8>
    %1 = "tosa.const"() <{values = dense<-3.902000e+01> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<5x2x8x9xi8>) -> tensor<1x2x8x9xi8>
    %3 = tosa.ceil %1 : (tensor<3xf32>) -> tensor<3xf32>
    %4 = tosa.add %2, %2 : (tensor<1x2x8x9xi8>, tensor<1x2x8x9xi8>) -> tensor<1x2x8x9xi8>
    %5 = tosa.rsqrt %3 : (tensor<3xf32>) -> tensor<3xf32>
    %cast = tensor.cast %4 : tensor<1x2x8x9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

