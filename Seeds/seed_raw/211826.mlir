module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<140> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = "tosa.const"() <{values = dense<141> : tensor<34xi32>}> : () -> tensor<34xi32>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<8xi32>, tensor<34xi32>) -> tensor<42xi32>
    %3 = tosa.bitwise_and %2, %2 : (tensor<42xi32>, tensor<42xi32>) -> tensor<42xi32>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<42xi32>) -> tensor<1xi32>
    %5 = tosa.reduce_product %4 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %6 = tosa.clamp %5 {max_val = 89 : i32, min_val = 38 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %7 = tosa.reduce_sum %6 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %8 = tosa.maximum %7, %7 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %9 = tosa.reduce_max %8 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %10 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %11 = tosa.tile %9, %10 : (tensor<1xi32>, !tosa.shape<1>) -> tensor<1xi32>
    %12 = tosa.bitwise_and %11, %6 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %12 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

