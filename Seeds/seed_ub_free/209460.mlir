module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-12> : tensor<4x3x6x3xi8>}> : () -> tensor<4x3x6x3xi8>
    %1 = "tosa.const"() <{values = dense<-9.486000e+01> : tensor<2x2x7x7xf32>}> : () -> tensor<2x2x7x7xf32>
    %2 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<4x3x6x3xi8>) -> tensor<4x3x1x3xi8>
    %3 = tosa.reduce_max %2 {axis = 1 : i32} : (tensor<4x3x1x3xi8>) -> tensor<4x1x1x3xi8>
    %4 = tosa.identity %3 : (tensor<4x1x1x3xi8>) -> tensor<4x1x1x3xi8>
    %5 = tosa.log %1 : (tensor<2x2x7x7xf32>) -> tensor<2x2x7x7xf32>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<2x2x7x7xf32>) -> tensor<2x2x7x7xf32>
    %7 = tosa.reciprocal %6 : (tensor<2x2x7x7xf32>) -> tensor<2x2x7x7xf32>
    %8 = tosa.const_shape  {values = dense<[2, 1, 1, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %9 = tosa.tile %6, %8 : (tensor<2x2x7x7xf32>, !tosa.shape<4>) -> tensor<4x2x7x21xf32>
    %10 = tosa.reduce_product %9 {axis = 0 : i32} : (tensor<4x2x7x21xf32>) -> tensor<1x2x7x21xf32>
    %11 = tosa.floor %7 : (tensor<2x2x7x7xf32>) -> tensor<2x2x7x7xf32>
    %cast = tensor.cast %4 : tensor<4x1x1x3xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %10 : tensor<1x2x7x21xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<2x2x7x7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

