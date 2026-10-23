module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-36> : tensor<1x9x6xi32>}> : () -> tensor<1x9x6xi32>
    %1 = "tosa.const"() <{values = dense<-1.259100e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %2 = tosa.const_shape  {values = dense<[2, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.tile %0, %2 : (tensor<1x9x6xi32>, !tosa.shape<3>) -> tensor<2x18x6xi32>
    %4 = tosa.ceil %1 : (tensor<5xf32>) -> tensor<5xf32>
    %5 = tosa.clz %3 : (tensor<2x18x6xi32>) -> tensor<2x18x6xi32>
    %6 = tosa.maximum %4, %4 : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    %7 = tosa.reduce_max %5 {axis = 2 : i32} : (tensor<2x18x6xi32>) -> tensor<2x18x1xi32>
    %8 = tosa.add %7, %7 : (tensor<2x18x1xi32>, tensor<2x18x1xi32>) -> tensor<2x18x1xi32>
    %9 = tosa.reciprocal %6 : (tensor<5xf32>) -> tensor<5xf32>
    %10 = tosa.abs %9 : (tensor<5xf32>) -> tensor<5xf32>
    %cast = tensor.cast %8 : tensor<2x18x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

