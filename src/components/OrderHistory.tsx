interface OrderItem {
  id: number;
  quantity: number;
  price_paid: number;
  products: {
    id: number;
    name: string;
    type: string;
    description: string;
  };
}

interface Order {
  id: number;
  status: string;
  tracking_number: string | null;
  created_at: string;
  shipped_at: string | null;
  delivered_at: string | null;
  order_items: OrderItem[];
}

interface OrderHistoryProps {
  orders: Order[];
  isLoading?: boolean;
}

const formatDate = (dateStr: string) => {
  return new Date(dateStr).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  });
};

const getStatusColor = (status: string) => {
  switch (status) {
    case 'pending':
      return 'bg-yellow-100 text-yellow-800';
    case 'shipped':
      return 'bg-blue-100 text-blue-800';
    case 'delivered':
      return 'bg-green-100 text-green-800';
    case 'canceled':
      return 'bg-red-100 text-red-800';
    default:
      return 'bg-gray-100 text-gray-800';
  }
};

export default function OrderHistory({ orders, isLoading = false }: OrderHistoryProps) {
  if (isLoading) {
    return <div className="text-center py-8">Loading orders...</div>;
  }

  if (orders.length === 0) {
    return (
      <div className="card text-center py-12">
        <p className="text-[var(--color-text-secondary)]">No orders yet.</p>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {orders.map(order => (
        <div key={order.id} className="card space-y-4">
          <div className="flex justify-between items-start">
            <div>
              <p className="text-sm text-[var(--color-text-secondary)]">Order #{order.id}</p>
              <p className="text-lg font-semibold text-[var(--color-text-primary)]">
                {formatDate(order.created_at)}
              </p>
            </div>
            <span className={`px-3 py-1 rounded-full text-sm font-semibold capitalize ${getStatusColor(order.status)}`}>
              {order.status}
            </span>
          </div>

          <div className="border-t border-gray-200 pt-4 space-y-2">
            {order.order_items.map(item => (
              <div key={item.id} className="flex justify-between text-sm">
                <div>
                  <p className="font-medium text-[var(--color-text-primary)]">{item.products.name}</p>
                  <p className="text-xs text-[var(--color-text-secondary)]">
                    {item.products.type} × {item.quantity}
                  </p>
                </div>
                <p className="font-semibold text-[var(--color-text-primary)]">
                  ${(item.price_paid / 100).toFixed(2)}
                </p>
              </div>
            ))}
          </div>

          {order.tracking_number && (
            <div className="border-t border-gray-200 pt-4">
              <p className="text-sm text-[var(--color-text-secondary)]">Tracking:</p>
              <p className="font-mono text-sm">{order.tracking_number}</p>
            </div>
          )}

          <div className="border-t border-gray-200 pt-4 text-sm space-y-2">
            <div className="flex items-center gap-2">
              <span className="text-green-600">✓</span>
              <span className="text-[var(--color-text-secondary)]">Ordered {formatDate(order.created_at)}</span>
            </div>
            {order.shipped_at && (
              <div className="flex items-center gap-2">
                <span className="text-blue-600">✓</span>
                <span className="text-[var(--color-text-secondary)]">Shipped {formatDate(order.shipped_at)}</span>
              </div>
            )}
            {order.delivered_at && (
              <div className="flex items-center gap-2">
                <span className="text-green-600">✓</span>
                <span className="text-[var(--color-text-secondary)]">Delivered {formatDate(order.delivered_at)}</span>
              </div>
            )}
          </div>
        </div>
      ))}
    </div>
  );
}