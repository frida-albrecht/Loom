module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<182> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<-1.584400e+02> : tensor<7x10xf32>}> : () -> tensor<7x10xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<1xi32>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.maximum %3, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.floor %1 : (tensor<7x10xf32>) -> tensor<7x10xf32>
    %6 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = tosa.negate %5, %6, %7 : (tensor<7x10xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<7x10xf32>
    %cast = tensor.cast %4 : tensor<1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<7x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

