module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-30> : tensor<6x7x9xi16>}> : () -> tensor<6x7x9xi16>
    %1 = "tosa.const"() <{values = dense<-1.713000e+01> : tensor<10x6x6x6xf32>}> : () -> tensor<10x6x6x6xf32>
    %2 = "tosa.const"() <{values = dense<77.4499969> : tensor<1x1x6x1xf32>}> : () -> tensor<1x1x6x1xf32>
    %3 = tosa.const_shape  {values = dense<[1, 3, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.const_shape  {values = dense<[3, 2, 6]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.slice %0, %3, %4 : (tensor<6x7x9xi16>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<3x2x6xi16>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<10x6x6x6xf32>}> : () -> tensor<10x6x6x6xf32>
    %a0 = tosa.maximum %1, %c0 : (tensor<10x6x6x6xf32>, tensor<10x6x6x6xf32>) -> tensor<10x6x6x6xf32>
    %6 = tosa.pow %a0, %2 : (tensor<10x6x6x6xf32>, tensor<1x1x6x1xf32>) -> tensor<10x6x6x6xf32>
    %7 = tosa.reduce_sum %6 {axis = 1 : i32} : (tensor<10x6x6x6xf32>) -> tensor<10x1x6x6xf32>
    %8 = tosa.exp %7 : (tensor<10x1x6x6xf32>) -> tensor<10x1x6x6xf32>
    %9 = tosa.const_shape  {values = dense<[2, 1, 1, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %10 = tosa.tile %7, %9 : (tensor<10x1x6x6xf32>, !tosa.shape<4>) -> tensor<20x1x6x18xf32>
    %11 = tosa.argmax %10 {axis = 3 : i32} : (tensor<20x1x6x18xf32>) -> tensor<20x1x6xi32>
    %cast = tensor.cast %5 : tensor<3x2x6xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<10x1x6x6xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<20x1x6xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}