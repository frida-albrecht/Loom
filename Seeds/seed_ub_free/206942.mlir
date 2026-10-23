module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<26> : tensor<9x2x2x1xi32>}> : () -> tensor<9x2x2x1xi32>
    %1 = "tosa.const"() <{values = dense<-2.556000e+01> : tensor<5x6xf32>}> : () -> tensor<5x6xf32>
    %2 = tosa.identity %0 : (tensor<9x2x2x1xi32>) -> tensor<9x2x2x1xi32>
    %3 = tosa.ceil %1 : (tensor<5x6xf32>) -> tensor<5x6xf32>
    %4 = tosa.intdiv %2, %2 : (tensor<9x2x2x1xi32>, tensor<9x2x2x1xi32>) -> tensor<9x2x2x1xi32>
    %5 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.const_shape  {values = dense<[2, 5]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.slice %3, %5, %6 : (tensor<5x6xf32>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<2x5xf32>
    %8 = tosa.reverse %4 {axis = 1 : i32} : (tensor<9x2x2x1xi32>) -> tensor<9x2x2x1xi32>
    %9 = tosa.reduce_max %8 {axis = 0 : i32} : (tensor<9x2x2x1xi32>) -> tensor<1x2x2x1xi32>
    %cast = tensor.cast %7 : tensor<2x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<1x2x2x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

