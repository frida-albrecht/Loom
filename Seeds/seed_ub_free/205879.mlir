module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-171> : tensor<7x9xi16>}> : () -> tensor<7x9xi16>
    %1 = "tosa.const"() <{values = dense<-140> : tensor<2x5x1xi32>}> : () -> tensor<2x5x1xi32>
    %2 = "tosa.const"() <{values = dense<-36> : tensor<1x1x1xi32>}> : () -> tensor<1x1x1xi32>
    %3 = tosa.const_shape  {values = dense<[21, 3, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.reshape %0, %3 : (tensor<7x9xi16>, !tosa.shape<3>) -> tensor<21x3x1xi16>
    %5 = tosa.intdiv %1, %2 : (tensor<2x5x1xi32>, tensor<1x1x1xi32>) -> tensor<2x5x1xi32>
    %6 = tosa.intdiv %5, %5 : (tensor<2x5x1xi32>, tensor<2x5x1xi32>) -> tensor<2x5x1xi32>
    %7 = tosa.clamp %5 {max_val = 21 : i32, min_val = 4 : i32} : (tensor<2x5x1xi32>) -> tensor<2x5x1xi32>
    %8 = tosa.clamp %6 {max_val = 21 : i32, min_val = 4 : i32} : (tensor<2x5x1xi32>) -> tensor<2x5x1xi32>
    %cast = tensor.cast %4 : tensor<21x3x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<2x5x1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %8 : tensor<2x5x1xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

