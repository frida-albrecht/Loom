module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-15> : tensor<6x7x3x9xi8>}> : () -> tensor<6x7x3x9xi8>
    %1 = "tosa.const"() <{values = dense<-1.753400e+02> : tensor<4x10xf32>}> : () -> tensor<4x10xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<6x7x3x9xi8>) -> tensor<1x7x3x9xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.negate %2, %3, %4 : (tensor<1x7x3x9xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x7x3x9xi8>
    %6 = tosa.sub %5, %5 : (tensor<1x7x3x9xi8>, tensor<1x7x3x9xi8>) -> tensor<1x7x3x9xi8>
    %7 = tosa.concat %6, %2 {axis = 0 : i32} : (tensor<1x7x3x9xi8>, tensor<1x7x3x9xi8>) -> tensor<2x7x3x9xi8>
    %8 = tosa.ceil %1 : (tensor<4x10xf32>) -> tensor<4x10xf32>
    %9 = tosa.logical_right_shift %7, %7 : (tensor<2x7x3x9xi8>, tensor<2x7x3x9xi8>) -> tensor<2x7x3x9xi8>
    %10 = tosa.concat %8, %8 {axis = 1 : i32} : (tensor<4x10xf32>, tensor<4x10xf32>) -> tensor<4x20xf32>
    %11 = tosa.reverse %9 {axis = 0 : i32} : (tensor<2x7x3x9xi8>) -> tensor<2x7x3x9xi8>
    %cast = tensor.cast %10 : tensor<4x20xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<2x7x3x9xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

