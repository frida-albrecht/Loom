module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<8x2x5x4xi1>}> : () -> tensor<8x2x5x4xi1>
    %1 = "tosa.const"() <{values = dense<-2.080000e+01> : tensor<6x8x9x6xf32>}> : () -> tensor<6x8x9x6xf32>
    %2 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<8x2x5x4xi1>) -> tensor<1x2x5x4xi1>
    %3 = tosa.argmax %2 {axis = 2 : i32} : (tensor<1x2x5x4xi1>) -> tensor<1x2x4xi32>
    %4 = tosa.abs %3 : (tensor<1x2x4xi32>) -> tensor<1x2x4xi32>
    %5 = tosa.add %4, %3 : (tensor<1x2x4xi32>, tensor<1x2x4xi32>) -> tensor<1x2x4xi32>
    %6 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %7 = tosa.transpose %5 {perms = array<i32: 0, 2, 1>} : (tensor<1x2x4xi32>) -> tensor<1x4x2xi32>
    %8 = tosa.reduce_max %7 {axis = 2 : i32} : (tensor<1x4x2xi32>) -> tensor<1x4x1xi32>
    %9 = tosa.sigmoid %1 : (tensor<6x8x9x6xf32>) -> tensor<6x8x9x6xf32>
    %10 = tosa.reduce_min %9 {axis = 3 : i32} : (tensor<6x8x9x6xf32>) -> tensor<6x8x9x1xf32>
    %11 = tosa.reduce_max %10 {axis = 2 : i32} : (tensor<6x8x9x1xf32>) -> tensor<6x8x1x1xf32>
    %12 = tosa.concat %8, %8 {axis = 1 : i32} : (tensor<1x4x1xi32>, tensor<1x4x1xi32>) -> tensor<1x8x1xi32>
    %cast = tensor.cast %11 : tensor<6x8x1x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %12 : tensor<1x8x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

